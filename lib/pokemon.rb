require 'pry'
class Pokemon
  attr_accessor :name, :type, :db, :id
  
  
  def initialize (id:,name:, type:, db:)
    @name = name
    @type = type
    @db = db
    @id= nil
  end
  
  def self.save(name,type,db)
    @db = db
      sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES(?,?);
            SQL
      @db.execute(sql,name,type) 
      
      @id = @db.execute("SELECT last_insert_rowid() FROM pokemon;")[0][0] 
    
  end
  
  def self.find(id,db)
    sql = "SELECT * FROM pokemon WHERE id = ?;"
    data = db.execute(sql,id).first  
    #binding.pry
    pokemon = Pokemon.new(id:id,name:data[1],type:data[2],db:db)      
    pokemon.id = id
    pokemon
  end
  
  
  # def update
  #    sql = <<-SQL
  #        UPDATE pokemon SET name = ?, type = ? WHERE id=?;
  #        SQL
  #  @db[:conn].execute(sql,self.name,self.type,self.id)
  #end
  
end
