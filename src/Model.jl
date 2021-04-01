module Model

import Base: ==

using StructTypes, Dates

export Image, ApiResponse, ImageId

mutable struct Image
    id::Int64 # service-managed
    episode::String
    start_time::Dates.Time
    end_time::Dates.Time
    text::String
    image:: String
end

mutable struct ApiResponse
    count:: Int64
    data:: Vector{Any}
end

mutable struct ImageId
    id:: Int64
end

==(x::Image, y::Image) = x.id == y.id
Image() = Image(0, "", Dates.Time(Dates.now()), Dates.Time(Dates.now()), "", "")
Image(episode, start_time, end_time, text, image) = Image(0, episode, start_time, end_time, text, image)
ApiResponse() = ApiResponse(0, zeros(1))
ImageId() = ImageId(0)
StructTypes.StructType(::Type{Image}) = StructTypes.Mutable()
StructTypes.idproperty(::Type{Image}) = :id
StructTypes.StructType(::Type{ApiResponse}) = StructTypes.Mutable()
StructTypes.StructType(::Type{ImageId}) = StructTypes.Mutable()

end # module