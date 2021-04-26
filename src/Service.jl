module Service

using JSON3

using ..Model, ..Mapper

function getImageById(id::Int64)::Image
    Mapper.get_by_id(id)
end

function getImageByText(text::String)::ApiResponse
    images_array = Mapper.get_by_text(text)
    ApiResponse(length(images_array), images_array)
end

function getImageIdsByText(text::String)::ApiResponse
    ids_array = Mapper.get_image_ids_by_text(text)
    ApiResponse(length(ids_array), ids_array)
end

function getRandomImageId()::Int64
    # total count of images is 84403
    # production app only has 3 episodes of first season
    rand(1: 1085)
end

end # module