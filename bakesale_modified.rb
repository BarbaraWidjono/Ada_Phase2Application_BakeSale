puts "How many different items were sold?"
num_of_items = gets.chomp.to_i

#This array will contain sales info for each item (name, sales price, net profit)
items_sold = []

#This array will contain only the names of the items being sold
item_name_array = []

counter = 1
while counter <=num_of_items
    puts "Enter name of item ##{counter}"
    item_name = gets.chomp

    puts "Sales price for item: $"
    item_price = gets.chomp.to_i

    puts "Net profit for each item sold: "
    item_net_profit = gets.chomp.to_i

    item_name_array.push(item_name)

    each_item = {
        "ItemName" => item_name,
        "#{item_name}_sell_price" => item_price,
        "#{item_name}_net_profit" => item_net_profit
    }

    items_sold.push(each_item)

    counter += 1
end

puts "How many friends participated in the bake sale? "
num_of_friends = gets.chomp.to_i

#This array will hold all the sales info for each friend
all_data = []

index = 1
while index <= num_of_friends

    #With each iteration of the while loop, a new friend_info hash is created. A new hash must be created for each new friend that is entered.
    friend_info = Hash.new(0)

    puts "Name of friend ##{index}"
    f_name = gets.chomp

    #Adding new key/value pair into the friend_info hash
    friend_info["Name"] = f_name

    #This inner_loop must be declared within the first while loop (but outside the second while loop) so that when the inner while loop is entered, the inner_loop will begin at a value of 0. If inner_loop is declared outside of the first while loop, the inner_loop value has already been incremented (after a full cycle of the inner while loop) and will not begin at a value of 0.
    inner_loop = 0
    while inner_loop < num_of_items
        a = item_name_array[inner_loop]

        puts "How many #{a}'s were sold? "
        num_sold = gets.chomp.to_i

        puts "How many #{a}'s are remaining (unsold)? "
        num_remaining = gets.chomp.to_i

        #Adding new key/value pair into the friend_info hash
        friend_info["#{a}_sold"] = num_sold
        friend_info["#{a}_remaining"] = num_remaining

        inner_loop += 1
    end

    all_data.push(friend_info)
    index += 1
end

puts "****** Item Inventory Infomation ******"
#Print out of items sold and pricing by iterating through the items_sold array
item_inventory_index = 0
while item_inventory_index < num_of_items
    x = items_sold[item_inventory_index]["ItemName"]
    puts "Item Name: #{x}"
    puts "Selling Price: #{items_sold[item_inventory_index]["#{x}_sell_price"]}"
    puts "Net Profit: #{items_sold[item_inventory_index]["#{x}_net_profit"]}"

    item_inventory_index += 1
end

#Sales Calculations
puts "****** Sales Summary for Each Friend ******"

#This loop accesses the hash data located within the specific index of the all_data array. Each hash data contains the name and sales info for each friend.
calc_index = 0
while calc_index < num_of_friends
    puts "Friend Name: #{all_data[calc_index]["Name"]}"

    #This loop is used to calculate profit info for each friend
    item_name_array_index = 0
    item_name_length = item_name_array.length
    while item_name_array_index < item_name_length
        #Variable b is the name of the product sold, obtained by accessing the item_name_array
        b = item_name_array[item_name_array_index]

        #This loop is used to access the selling price per item by iterating through the items_sold array.
        items_sold_index = 0
        while items_sold_index < num_of_items
            if  items_sold[items_sold_index]["ItemName"] == item_name_array     [item_name_array_index]
                selling_price = items_sold[items_sold_index]["#{b}_sell_price"]
                items_sold_index += 1
            else
                items_sold_index += 1
            end
        end

        num_of_item_sold_per_friend = all_data[calc_index]["#{b}_sold"]
        item_profit_per_friend = selling_price * num_of_item_sold_per_friend

        puts "Number of #{b} sold: #{all_data[calc_index]["#{b}_sold"]}"
        puts "#{item_name_array[item_name_array_index]} gross profit: #{item_profit_per_friend}"

        item_name_array_index += 1
    end

    puts "------"
    calc_index += 1
end
