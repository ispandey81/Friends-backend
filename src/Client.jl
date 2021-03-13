module Client

using HTTP, JSON3
using ..Model

const SERVER = Ref{String}("http://localhost:8080")

function getImage(id)
    resp = HTTP.get(string(SERVER[], "/api/image/=$id"))
    return JSON3.read(resp.body, Image)
end

end # module