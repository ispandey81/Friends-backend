using Test, Friends

const DBFILE = joinpath(dirname(pathof(Friends)), "../test/friendsdb.sqlite")

server = Friends.run(DBFILE)

img1 = Client.getImageById(1)
@test img1.id == 1
@test img1.episode == "s01e01"