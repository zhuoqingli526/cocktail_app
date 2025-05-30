class CocktailChatController < ApplicationController
  def show
    @session_id = SecureRandom.uuid
    @messages = []
    render({ :template => "cocktail_chat/show" })
  end

  def send_message
    session_id = params.fetch("query_session_id")
    user_input = params.fetch("query_body")

    # Save user message
    user_message = Message.new
    user_message.role = "user"
    user_message.body = user_input
    user_message.session_id = session_id
    user_message.save!

    # Prepare messages
    existing_messages = Message.where(session_id: session_id).order(:created_at)

    chat = OpenAI::Chat.new
    chat.model = "gpt-4.1-nano" 

    # Set system prompt 
    chat.system("You are a friendly bartender assistant who knows a lot about cocktails, recipes, and drink history.")

    # Add prior messages
    existing_messages.each do |m|
      if m.role == "user"
        chat.user(m.body)
      else
        chat.assistant(m.body)
      end
    end

    # Get response
    llm_response = chat.assistant!

    # Save assistant reply
    assistant_message = Message.new
    assistant_message.role = "assistant"
    assistant_message.body = llm_response
    assistant_message.session_id = session_id
    assistant_message.save!

    # Redirect back to chat with same session
    @messages = Message.where(session_id: session_id).order(:created_at)
    @session_id = session_id
    render({ :template => "cocktail_chat/show" })
  end
end
