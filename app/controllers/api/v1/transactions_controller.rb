module Api
  module V1
    class TransactionsController < ApplicationController


      def show
        @transaction = Transaction.find(params[:id])

        render json: @transaction, serializer: TransactionSerializer, status: :ok
      end

      def search
        @member = Member.find(params[:member_id])

        query = params[:query]

        @transactions = Transaction.search(query).where(member_id: @member.id)

        render json: @transactions, each_serializer: TransactionSerializer, status: :ok
      end

      def create
        @transaction = Transaction.new(transaction_params)
        @transaction.group = @transaction.category.kind

        if @transaction.category.total_amounts.find_by(member_id: @transaction.member_id).nil?
          @transaction.category.total_amounts.create(member_id: @transaction.member_id, amount: @transaction.amount, kind: @transaction.category.kind)
        else
          total_amount = @transaction.category.total_amounts.find_by(member_id: @transaction.member_id).amount + @transaction.amount
          @transaction.category.total_amounts.find_by(member_id: @transaction.member_id).update(amount: total_amount)
        end

        if @transaction.save
          render json: @transaction, serializer: TransactionSerializer, status: :created
        else
          render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        @transaction = Transaction.find(params[:id])

        if @transaction.amount != transaction_params[:amount].to_f
          total_amount = @transaction.category.total_amounts.find_by(member_id: @transaction.member_id).amount - @transaction.amount + transaction_params[:amount].to_f
          @transaction.category.total_amounts.find_by(member_id: @transaction.member_id).update(amount: total_amount)
        end

        if @transaction.update(transaction_params)
          render json: @transaction, serializer: TransactionSerializer, status: :ok
        else
          render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @transaction = Transaction.find(params[:id])

        if @transaction.destroy
          puts "🌱🌱🌱 Transaction deleted! 🌱🌱🌱"

          render json: @transaction, serializer: TransactionSerializer, status: :ok
        else
          render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def transaction_params
        params.require(:transaction).permit(:name, :group, :amount, :member_id, :category_id, :created_at)
      end
    end    
  end
end
