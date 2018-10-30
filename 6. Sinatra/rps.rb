require 'sinatra'

set :bind, "0.0.0.0"

DEFEAT = { rock:      :scissors,
           paper:     :rock,
           scissors:  :paper }

OPTIONS = DEFEAT.keys

before do
  content_type :txt
end

get '/play/:element' do
  user_play = params[:element].to_sym
  if !OPTIONS.include?(user_play)
    halt 403, "You must play with one of: #{ OPTIONS }."
  end

  computer_play = OPTIONS.sample

  if user_play == computer_play
    "You tied with the computer. Try again!"
  elsif computer_play == DEFEAT[user_play]
    "Nicely done: #{ user_play } beats #{ computer_play }."
  else
    "Ouch: #{ computer_play} beats #{ user_play}."
  end
end
