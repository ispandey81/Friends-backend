module Service

using ..Model, ..Mapper

function getImageById(id::Int64)::Image
    Mapper.get_by_id(id)
end

function getImageByText(text::String)::Vector{Image}
    Mapper.get_by_text(text)
end

end # module