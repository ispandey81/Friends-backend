module Client

using HTTP, JSON3
using ..Model

const SERVER = Ref{String}("http://localhost:8080")

function getImageById(id)
    resp = HTTP.get(string(SERVER[], "/api/image/id/$id"))
    return JSON3.read(resp.body, Image)
end

function getImageIdsByText(text)
    resp = HTTP.get(string(SERVER[], "/api/image/text/$text"))
    return JSON3.read(resp.body, ApiResponse)
end

function getRandomImageId()
    resp = HTTP.get(string(SERVER[], "/api/image/random"))
    return JSON3.read(resp.body, Int64)
end

end # module