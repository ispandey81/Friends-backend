module Resource

using Dates, HTTP, JSON3
using ..Model, ..Service

const ROUTER = HTTP.Router()

headers = [
    "Access-Control-Allow-Origin" => "*",
    "Access-Control-Allow-Headers" => "*",
    "Access-Control-Allow-Methods" => "POST, GET, OPTIONS"
]

getImageById(req) = Service.getImageById(parse(Int, HTTP.URIs.splitpath(req.target)[4]))::Image
HTTP.@register(ROUTER, "GET", "/api/image/id/*", getImageById)

getImageByText(req) = Service.getImageByText(HTTP.URIs.unescapeuri(HTTP.URIs.splitpath(req.target)[4]))::Vector{Image}
HTTP.@register(ROUTER, "GET", "/api/image/text/*", getImageByText)

function requestHandler(req)
    obj = HTTP.handle(ROUTER, req)
    return HTTP.Response(200, headers; body = JSON3.write(obj))
end

function run()
    HTTP.serve(requestHandler, "0.0.0.0", 8080)
end

end # module