module Model

import Base: ==

using StructTypes, Dates

export Image

mutable struct Image
    id::Int64 # service-managed
    episode::String
    start_time::Dates.Time
    end_time::Dates.Time
    text::String
    image:: String
end

==(x::Image, y::Image) = x.id == y.id
Image() = Image(0, "", Dates.Time(Dates.now()), Dates.Time(Dates.now()), "", "")
Image(episode, start_time, end_time, text, image) = Image(0, episode, start_time, end_time, text, image)
StructTypes.StructType(::Type{Image}) = StructTypes.Mutable()
StructTypes.idproperty(::Type{Image}) = :id

end # module