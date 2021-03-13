using Test, Friends

const DBFILE = joinpath(dirname(pathof(Friends)), "../test/friendsdb.sqlite")

server = @async Friends.run(DBFILE)