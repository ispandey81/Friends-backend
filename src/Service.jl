module Service

using ..Model, ..Mapper

function getImageById(id::Int64)::Image
    Mapper.get_by_id(id)
end

function getImageByText(text::String)::Vector{Image}
    Mapper.get_by_text(text)
end

function getRandomImageId()::Int64
    total_count = length(Mapper.getAllImages());
    rand(1: total_count)
end

end # module