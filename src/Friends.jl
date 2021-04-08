module Friends

export Model, Mapper, Service, Resource, Client

include("Workers.jl")
using .Workers

include("Model.jl")
using .Model

include("Mapper.jl")
using .Mapper

include("Service.jl")
using .Service

include("Resource.jl")
using .Resource

include("Client.jl")
using .Client

function run(dbfile)
    Workers.init()
    Mapper.init(dbfile)
    Resource.run()
end

end # module
