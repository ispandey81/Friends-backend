module Mapper

using ..Model
using SQLite, DBInterface, Strapping, Tables

const DB = Ref{SQLite.DB}()
getdb() = DB[]
const COUNTER = Ref{Int64}(0)

function init(dbfile)
    if isfile(dbfile)
        DB[] = SQLite.DB(dbfile)
    else
        DB[] = SQLite.DB(dbfile)
        DBInterface.execute(getdb(), """
            CREATE TABLE friends_images (
                id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                episode TEXT NOT NULL
                start_time TEXT NOT NULL,
                end_time TEXT NOT NULL,
                text TEXT NOT NULL,
                image TEXT NOT NULL 
            )
        """)
        DBInterface.execute(getdb(), """
            CREATE INDEX idx_img_id ON friends_images (id)
        """)
    end
    return
end

get_by_id(id) = Strapping.construct(Image, DBInterface.execute(DBInterface.@prepare(getdb, "SELECT * FROM friends_images WHERE id = ?"), (id,)))

get_by_text(text) = Strapping.construct(Vector{Image}, DBInterface.execute(getdb(), "SELECT * FROM friends_images WHERE text like '%$text%'"))

getAllImages() = Strapping.construct(Vector{Image}, DBInterface.execute(DBInterface.@prepare(getdb, "SELECT * FROM friends_images")))

end # module