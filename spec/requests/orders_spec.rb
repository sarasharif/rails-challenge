require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  describe 'POST /orders' do
    before {
			Customer.create(name: "Lucy", email: "Lucy@DogeBear.com")
			Product.create()
			Variant.create(stock_amount: 10, product_id: 1, cost: 10)
		}

    context 'when the request doesn\'t contain the `customer_id`' do
      before { post '/orders', params: { variants: { "1": 100 } } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
		end
		
		context 'when the request doesn\'t contain the `variants`' do
      before { post '/orders', params: { customer_id: 1 } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when the request `customer_id` is invalid' do
      before { post '/orders', params: { customer_id: "Not a real ID", variants: { "1": 4 } } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
		end
		
		context 'when the request `variant` is invalid' do
      before { post '/orders', params: { customer_id: 1, variants: { "Not a real variant ID": 4 } } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

		context 'when there is insufficient stock' do
      before {
				post '/orders', params: {
					customer_id: 1,
					variants: {"1": 100 }
				}
			}

			it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
		end
		
		context 'when it\'s all good' do
      before {
				post '/orders', params: {
					customer_id: 1,
					variants: {"1": 1 }
				}
			}

			it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
	end
end
