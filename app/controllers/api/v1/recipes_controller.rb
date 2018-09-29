module Api
  module V1
    class RecipesController < ApplicationController
      def index
        recipes = Recipe.order('created_at DESC')
        render json: {data: recipes}, status: :ok
      end

      def show
        recipe = Recipe.find(params[:id])
        render json: {data: recipe}, status: :ok
      end

      def create
        recipe = Recipe.new(recipe_params)
        # current user is the creator of the recipe
        recipe.user_id = current_user.id
        if recipe.save
          render json: {data: recipe}, status: :ok
        else
          render json: {errors: recipe.errors}, status: :unprocessable_entity
        end
      end

      def update
        recipe = Recipe.find(params[:id])
        if recipe.update_attributes(recipe_params)
          render json: {data: recipe}, status: :ok
        else
          render json: {errors: recipe.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        recipe = Recipe.find(params[:id])
        if recipe.destroy
          render status: :ok
        else
          render json: {errors: recipe.errors}, status: :unprocessable_entity
        end
      end

      private

      def recipe_params
        params.permit(:title, :category, :preparation_time, :oven_time, :ingredients, :steps, :image)
      end
    end
  end
end