#Intro to the program
puts "Would you like to enter the Bake Sale Tracker? (Y/N)"

#Sets user's answer to uppercase to account for lower case responses
reply = gets.chomp.upcase

#Setting variable which will hold all information
all_data = []

#Counter to keep track of the friend number
counter = 1

#Code flow logic to decide if the user will enter or exit the program
if  reply == "Y" || reply == "YES"

    #User entering the total number of friends participating (this accounts for more than 4 friends participating)
    puts "How many friends participated in the Bake Sale?"
    num_of_friends = gets.chomp.to_i

    while counter <= num_of_friends do

        puts "Please enter the name of friend ##{counter}"
        name = gets.chomp.capitalize

        #Converting entries into an integer so calculations can be made
        puts "What are the total number of cookies sold?"
        cookies_sold = gets.chomp.to_i

        puts "What are the total number of pound cakes sold?"
        pcakes_sold = gets.chomp.to_i

        puts "What are the total number of cookies remaining (unsold)?"
        cookies_unsold = gets.chomp.to_i

        puts "What are the total number of pound cakes remaining (unsold)?"
        pcakes_unsold = gets.chomp.to_i

        #Verify data before inserted into all_data array
        puts "Name: #{name}"
        puts "Cookies Sold: #{cookies_sold}"
        puts "Pound Cakes Sold: #{pcakes_sold}"
        puts "Unsold Cookies: #{cookies_unsold}"
        puts "Unsold Pound Cakes: #{pcakes_unsold}" 
        puts "Is the following information correct? (Y/N)"
        check = gets.chomp.capitalize

        #If info is correct, insert into all_data array and increment counter
        if  check == "Y" || check == "YES"

            #Create new hash for each friend
            friend_info = {
                "FriendName" => name,
                "CookiesSold" => cookies_sold,
                "PoundCakesSold" => pcakes_sold,
                "UnsoldCookies" => cookies_unsold,
                "UnsoldPoundCakes" => pcakes_unsold
            }
            #Insert the friend_info hash into the all_data array
            all_data.push(friend_info)
            
            puts "Data Entered"
            #Increment counter for the next friend's information
            counter += 1
            
        else 
            puts "Looks like you didn't confirm that the above information was correct. Let's re-enter that data :)"
            #Leaving counter unchanged so it repeats inquiry for friends data
        end
        
    end
    puts "*****SUMMARY*****"
    puts "Amounts raised by each friend:"

    #Displaying sales summary for each friend
    #The net_profit array will hold the net_sales from each friend. This will be used later to determine which friend(s) made the most.
    net_profit = []
    sum_all_net_sales = 0
    summary_count = 0

    while summary_count < num_of_friends
        f_name = all_data[summary_count]["FriendName"]
        gross_sales = (all_data[summary_count]["CookiesSold"]*2) + 
                (all_data[summary_count]["PoundCakesSold"]*6)
        net_sales = (all_data[summary_count]["CookiesSold"]*1) + 
                (all_data[summary_count]["PoundCakesSold"]*3)

        #Pushing the net sales from each friend into the net_profit array, to be used later
        net_profit.push(net_sales)

        #Summing the net_sales from each friend (net amount raised overall) to be printed later
        sum_all_net_sales += net_sales

        puts "  #{f_name}: $#{gross_sales} (gross), $#{net_sales} (net)"
        summary_count += 1
    end

    #Sorting the net_profit array and taking the last value which represents the max net profit made by a single friend
    max_net_profit = net_profit.sort.last

    #Determining which friend(s) made the most money(net value). Creating an friend_sales array to store hashes containing the name and net sales from each friend
    start = 0
    friend_sales = []

    while start < num_of_friends
        net_sales_per_friend = (all_data[start]["CookiesSold"]*1) + 
        (all_data[start]["PoundCakesSold"]*3)

        corresponding_friend_name = all_data[start]["FriendName"]

        individual_net_sales = {
            "FriendName" => corresponding_friend_name,
            "NetSales" => net_sales_per_friend
        }

        friend_sales.push(individual_net_sales)
        start += 1
    end
    
    #Pulling out the name(s) of the friend(s) from the friend_sales array that made the most net sales. Using a max_seller array to account for ties
    max_seller = []
    index = 0
    while index < num_of_friends
        if  friend_sales[index]["NetSales"] == max_net_profit
            max_seller.push(friend_sales[index]["FriendName"])
            index += 1
        else
            index += 1
        end
        
    end

    #Determining amount raised by selling cookies and pound cake (separate values)
    total_gross_sales_cookies = 0
    total_gross_sales_pcakes = 0
    total_net_sales_cookies = 0
    total_net_sales_pcakes = 0

    start_index = 0
    while start_index < num_of_friends
        t_g_s_c = all_data[start_index]["CookiesSold"]*2
        total_gross_sales_cookies += t_g_s_c

        t_g_s_p = all_data[start_index]["PoundCakesSold"]*6
        total_gross_sales_pcakes += t_g_s_p

        t_n_s_c = all_data[start_index]["CookiesSold"]*1
        total_net_sales_cookies += t_n_s_c

        t_n_s_p = all_data[start_index]["PoundCakesSold"]*3
        total_net_sales_pcakes += t_n_s_p

        start_index += 1
    end

    #Displaying results
    puts "Friend(s) that raised the most overall in net sales: #{max_seller.join(", ")}"
    puts "Total amount raised by selling cookies: $#{total_gross_sales_cookies} (gross), $#{total_net_sales_cookies} (net)"
    puts "Total amount raised by selling pound cakes: $#{total_gross_sales_pcakes} (gross), $#{total_net_sales_pcakes} (net)"
    puts "Net amount raised overall: $#{sum_all_net_sales}"
    puts "Thank you for using the Bake Sale Tracker proogram"
    puts "*******END*******"

elsif reply == "N" || reply == "NO"
    puts "Goodbye"
else
    puts "You chose an invalid option. Please restart the program."
end