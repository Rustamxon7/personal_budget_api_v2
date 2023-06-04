module Api
  module V1
    class MembersController < ApplicationController
      def create
        username = params[:username]
        user_id = current_user.id
        image = params[:image]

        @member = Member.new(username: username, user_id: user_id, image: image)

        if @member.save
          render json: @member, status: :created
        else
          render json: @member.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @member = Member.find(params[:id])

        unless @member.username == current_user.username
          @member.destroy
          render json: @member, status: :ok
        end
        
        render json: @member, status: :ok
      end

      def remove_from_member
        @category = Category.find(params[:category_id])
        @member = Member.find(params[:id])

        @category.members.delete(@member)
        Member.refresh
        @category.members_ids.delete(@member.id)

        render json: @category, status: :ok
      end

      def update
        @category = Category.find(params[:id])

        if params[:category][:members_ids].present?
          @members_ids_to_add = params[:category][:members_ids].map(&:to_i) - @category.members_ids
          @members_ids_to_remove = @category.members_ids - params[:category][:members_ids].map(&:to_i)


          @members_ids_to_add.each do |member_id|
            @category.members << Member.find(member_id)
          end

          @members_ids_to_remove.each do |member_id|
            @category.members.delete(Member.find(member_id))
            @category.transactions.where(member_id: member_id).destroy_all
          end
        end

        if @category.update(category_params)

          render json: @category, status: :ok
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end
    
      private
    
      def member_params
        params.require(:member).permit(:username, :user_id, :image)
      end
    end    
  end
end