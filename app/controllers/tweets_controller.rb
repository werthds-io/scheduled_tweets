class TweetsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = Current.user.tweets
  end

  def create
    @tweet = Current.user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path, notice: "Successfully scheduled tweet"
    else
      render :new
    end
  end

  def new
    @tweet = Tweet.new
  end

  def show
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: "Successfully updated tweet"
    else
      render :new
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "Successfully unscheduled tweet"
  end

  private
  
  def tweet_params
    params.require(:tweet).permit(:twitter_account_id, :body, :publish_at )    
  end

  def set_tweet
    @tweet = Current.user.tweets.find(params[:id])
  end

end
