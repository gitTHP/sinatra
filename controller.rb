
class ApplicationController < Sinatra::Base
    get '/' do 
      require './lib/gossip.rb'
      
      gossips=Gossip.all
     
      
      erb :index, :locals => {gossips:gossips}
    end

    get '/gossip/new' do
        erb :gossip
    end  

    get '/gossip/detail/:index' do 
        require './lib/gossip.rb'
        gossips=Gossip.all 
        gossip_view=""

        puts "GET PARAMS"
        puts params["index"]
        gossips.each_with_index do |gossip,index|
            puts "GET INDEX"
            puts index
            if (index)==params["index"].to_i
                gossip_view=gossip
            end
        end 
        
        erb :detail, :locals=>{gossip:gossip_view,index:params["index"].to_i}
    end

    post '/gossips/new' do 
        require './lib/gossip.rb'
        newGossip=Gossip.new
        newGossip.save(params[:gossip_author],params[:gossip_content])
        
        
        redirect '/'
    end 

    get '/gossip/edit/:index' do  
        require './lib/gossip.rb' 
        gossips=Gossip.all
        gossip_view=""
        gossips.each_with_index do |gossip,index|
            if (index)==params["index"].to_i
                gossip_view=gossip
            end
        end 

        erb :edit , :locals=>{gossip:gossip_view,index_to_update:params["index"].to_i}
        

    end 

    post "/gossip/edit/:index" do 
       
        require './lib/gossip.rb'
        gossips=Gossip.all
        gossips.each_with_index do |gossip,index|
            if (index)==params["index"].to_i
                new_gossip=Gossip.new 
                new_gossip.update(params["index"].to_i,params[:gossip_author],params[:gossip_content])
                
            end
        end 
        redirect '/'
    end
  
    run! if app_file == $0 

    
  end