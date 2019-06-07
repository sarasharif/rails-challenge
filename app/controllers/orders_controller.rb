class OrdersController < ApplicationController
	def show
		@order = Order.find(params[:id])
		render json: {
			date_created: @order.created_at,
			customer: @order.customer,
			total_cost: @order.cost,
			order_status: @order.status,
			items: @order.suborders.map do |suborder|
				{
					id: suborder.variant_id,
					name: suborder.variant.name,
					price: suborder.variant.cost,
					quantity: suborder.count,
				}
			end
		}
	end

	def create
		if !invalid_order_request
			@order = Order.new(
				customer_id: order_params["customer_id"],
				cost: calculate_total_cost,
				status: 0
			)

			if @order.save
				generate_suborders
				return head 200
			else
				return head 500
				# This error I definitely want to alert `loudly` on
				# even though we'll capture this response on the client 
				# to render a please-try-again message
			end
		end

	end

	private

	def invalid_order_request
		return head 400 if !contains_required_parameters
		return head 404 if !valid_customer_and_variant_ids
		return head 422 if !sufficient_stock
		return false
	end

	# Here, however, I would personally prefer to capture these errors and 
	# technically send back a 200 in the header but with a body like
	# {
	# 	error: {
	# 		code: 422,
	# 		message: "Insufficient stock for item ###"
	# 	}
	# }
	# to the client, so we don't get paged in the middle of the night when 
	# someone mass clicks --BUY-- with an empty cart
	
	def contains_required_parameters
		return order_params["customer_id"] && order_params["variants"]
	end

	def valid_customer_and_variant_ids
		@variants = order_params["variants"]
		@variant_ids = @variants.keys
		is_valid_customer = Customer.exists?(order_params["customer_id"])
		all_variant_ids_valid = @variant_ids.all?{|var_id| Variant.exists?(var_id)}
		return is_valid_customer && all_variant_ids_valid
	end
	
	def sufficient_stock
		return @variant_ids.all? do |var_id|
			Variant.find(var_id).stock_amount >= @variants[var_id].to_i
		end
	end

	def calculate_total_cost
		order_params["variants"].to_h.reduce(0) do |accum, (id, quant)|
			accum += quant.to_i * Variant.find(id).cost
		end
	end

	def generate_suborders
		order_params["variants"].to_h.each do |var_id, count|
			Suborder.create!(
				count: count,
				variant_id: var_id,
				order_id: @order.id
			)
		end
	end

	def order_params
		params.permit(:customer_id, :variants => {})
	end

end