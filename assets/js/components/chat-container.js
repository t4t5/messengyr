// assets/js/components/chat-container.js

import React from 'react';
import ReactDOM from 'react-dom';
import { connect } from 'react-redux';

import ChatMessage from './chat-message';

function scrollToBottom() {
  let chatEl = document.querySelector('.chat ul');
  if (!chatEl) return false;

  chatEl.scrollTop = chatEl.scrollHeight;
}

class ChatContainer extends React.Component {

  constructor(props) {
    super(props);
    
    this.state = {
      draft: '',
    };
  }

  componentDidUpdate(prevProps) {
    let prevRoomId = prevProps.room && prevProps.room.id;
    let newRoomId  = this.props.room && this.props.room.id;

    let prevNumMessages = prevProps.messages.length;
    let newNumMessages  = this.props.messages.length;

    let changedRoom  = (prevRoomId !== newRoomId);
    let addedMessage = (prevNumMessages !== newNumMessages);

    if (changedRoom || addedMessage) {
      scrollToBottom();
    }
  }

  updateDraft(e) {
    this.setState({
      draft: e.target.value,
    });
  }

  handleKeyPress(e) {
    if (e.key === "Enter") {
      this.sendMessage(); 
    }
  }

  sendMessage() {
    let message = this.state.draft;

    if (!message) return false;

    let room = this.props.room;

    room.channel.push('message:new', {
      text: message,
      room_id: room.id,
    });

    this.setState({
      draft: ''
    });
  }

  render() {

    let messages = this.props.messages.map((message) => {
      return (
        <ChatMessage
          key={message.id}
          message={message}
        />
      );
    });

    return (
      <div className="chat">

        <ul>
          {messages}
        </ul>

        <div className="compose-box">
          <input 
            placeholder="Type a message..." 
            value={this.state.draft}
            onChange={this.updateDraft.bind(this)}
            onKeyPress={this.handleKeyPress.bind(this)}
          />
          <button onClick={this.sendMessage.bind(this)}>
            Send
          </button>
        </div>

      </div>
    )
  }
}

ChatContainer.defaultProps = {
  messages: [],
};

const mapStateToProps = (state) => {
  let activeRoom = state.filter((room) => {
    return room.isActive;
  })[0];

  return {
    messages: (activeRoom) ? activeRoom.messages : [],
    room: activeRoom,
  }
};

ChatContainer = connect(
  mapStateToProps,
)(ChatContainer);

export default ChatContainer;
