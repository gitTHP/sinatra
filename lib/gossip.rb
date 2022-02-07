class Gossip  

    def save(author,content) 
        require 'csv'
        CSV.open("./db/gossip.csv", "ab") do |csv|
          csv << [author,content]
        end
    end 

    def update (index_to_update,author,content) 
        all_gossips=CSV.read('./db/gossip.csv') 
        all_gossips.each_with_index do |gossip,index|
            if index_to_update==index 
                all_gossips[index][0]=author 
                all_gossips[index][1]=content
            end

          

        end 

        
    end

    

    def self.all
        require 'csv'
        all_gossips=CSV.read('./db/gossip.csv')
        return all_gossips
    end

end