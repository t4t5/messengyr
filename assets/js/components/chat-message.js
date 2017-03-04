// assets/js/components/chat-message.js

import React from 'react';
import ReactDOM from 'react-dom';

class ChatMessage extends React.Component {
  render() {

    let message = this.props.message;
    let messageClass = (message.outgoing) ? 'user' : 'counterpart';

    return (
      <li className={messageClass}>
        <p>
          {message.text}
        </p>
      </li>
    )
  }
}

export default ChatMessage;
