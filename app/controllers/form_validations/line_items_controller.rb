# class FormValidations::LineItemsController < lineItemsController
#     def update
#       @line_item.assign_attributes(line_item_params)
#       @line_item.valid?
#       respond_to do |format|
#         format.text { render partial: 'line_items/form', locals: { line_item: @line_item }, formats: [:html] } 
#       end
#     end
    
#     def create
#       @post = LineItem.new(line_item_params)
#       @post.validate
#       respond_to do |format|
#         format.text { render partial: 'line_items/form', locals: { line_item: @line_item }, formats: [:html] } 
#       end
#     end
#   end