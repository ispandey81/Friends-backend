module Resource

using Dates, HTTP, JSON3
using ..Model, ..Service

const ROUTER = HTTP.Router()

headers = [
    "Access-Control-Allow-Origin" => "*",
    "Access-Control-Allow-Headers" => "*",
    "Access-Control-Allow-Methods" => "POST, GET, OPTIONS",
    "Transfer-Encoding" => "gzip, chunked"
]

getImageById(req) = Service.getImageById(parse(Int, HTTP.URIs.splitpath(req.target)[4]))::Image
HTTP.@register(ROUTER, "GET", "/api/image/id/*", getImageById)

getImageIdsByText(req) = Service.getImageIdsByText(HTTP.URIs.unescapeuri(HTTP.URIs.splitpath(req.target)[4]))::ApiResponse
HTTP.@register(ROUTER, "GET", "/api/image/text/*", getImageIdsByText)

getRandomImageId(req) = Service.getRandomImageId()::Int64
HTTP.@register(ROUTER, "GET", "/api/image/random", getRandomImageId)

function requestHandler(req)
    start = Dates.now(Dates.UTC)
    @info (timestamp = start, event = "ServiceRequestBegin", tid = Threads.threadid(), method = req.method, target = req.target)
    local resp
    try
        obj = HTTP.handle(ROUTER, req)
        resp = HTTP.Response(200, headers; body=JSON3.write(obj))
    catch e
        s = IOBuffer()
        showerror(s, e, catch_backtrace(); backtrace=true)
        errormsg = String(resize!(s.data, s.size))
        @error errormsg
        resp = HTTP.Response(500, errormsg)
    end
    stop = Dates.now(Dates.UTC)
    @info (timestamp = stop, event = "ServiceRequestEnd", tid = Threads.threadid(), method = req.method, target = req.target, duration = Dates.value(stop - start), status = resp.status, bodysize = length(resp.body))
    return resp
end

function run()
    HTTP.serve(requestHandler, "0.0.0.0", 8080)
end

end # module