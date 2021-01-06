class Api::CategoriesController < ApplicationController
  def index
    render json: Category.all
  end

  def new_game
    categories = Category.limit(2).order("Random()")
    categories_data = categories.map do |cat|
      {
        category: cat.name,
        category_id: cat.id,
        cards: cat.cards,
      }
    end
    render json: { data: categories_data }
    # render json: categories.to_json(include: [:cards])
    # serialize data
  end

  def create_category_with_cards
    new_category = Category.create(name: params[:name])

    if params[:q1]
      new_category.cards.create(question: params[:q1], a1: params[:q1_a1], a2: params[:q1_a2], correct_answer: params[:q1_correct_answer], points: params[:q1_points])
    end

    if params[:q2]
      new_category.cards.create(question: params[:q2], a1: params[:q2_a1], a2: params[:q2_a2], correct_answer: params[:q2_correct_answer], points: params[:q2_points])
    end

    if params[:q3]
      new_category.cards.create(question: params[:q3], a1: params[:q3_a1], a2: params[:q3_a2], correct_answer: params[:q3_correct_answer], points: params[:q3_points])
    end

    render json: new_category.to_json(include: [:cards])
  end

  def create_card
    category = Category.find(params[:id])

    category.cards.create(question: params[:question], a1: params[:a1], a2: params[:a2], correct_answer: params[:correct_answer], points: params[:points])
  end
end
