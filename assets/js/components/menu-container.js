// assets/js/components/menu-container.js

import React from 'react';
import ReactDOM from 'react-dom';
import { connect } from 'react-redux';

import MenuMessage from './menu-message';

import { setRooms, selectRoom, addRoom, addMessage } from '../actions';

import socket from "../socket";

let getRoomChannel = (roomId) => {
  let channel = socket.channel(`room:${roomId}`);

  channel.join()
  .receive("ok", resp => {
    console.info(`Joined room ${roomId} successfully`, resp)
  })
  .receive("error", resp => {
    console.error(`Unable to join ${roomId}`, resp)
  });

  return channel;
}

class MenuContainer extends React.Component {

  componentDidMount() {
    fetch('/api/rooms', {
      headers: {
        "Authorization": "Bearer " + window.jwtToken,
      },
    })
    .then((response) => {
      return response.json();
    })
    .then((response) => {
      let rooms = response.rooms;

      rooms.forEach((room) => {
        room.channel = getRoomChannel(room.id);
        this.listenToNewMessages(room);
      });

      this.props.setRooms(rooms);

      let firstRoom = rooms[0];

      if (firstRoom) {
        this.props.selectRoom(firstRoom.id);
      }
    })
    .catch((err) => {
      console.error(err);
    });
  }
  
  getNewMessage(room, messageId) {
    fetch(`/api/messages/${messageId}`, {
      headers: {
        "Authorization": "Bearer " + window.jwtToken,
      },
    })
    .then((response) => {
      return response.json();
    })
    .then((response) => {
      // Call the "addMessage" action:
      this.props.addMessage(response.message, room.id);
    })
    .catch((err) => {
      console.error(err);
    });
  }

  listenToNewMessages(room) {
    room.channel.on('message:new', resp => {
      let messageId = resp.messageId;

      this.getNewMessage(room, messageId);
    });
  }

  createRoom() {
    let username = prompt("Enter a username", "tristan");

    let data = new FormData();
    data.append("counterpartUsername", username);

    fetch('/api/rooms', {
      method: "POST",
      headers: {
        "Authorization": "Bearer " + window.jwtToken,
      },
      body: data,
    })
    .then((response) => {
      return response.json();
    })
    .then((response) => {
      let room = response.room;

      this.props.addRoom(room);
    })
    .catch((err) => {
      console.error(err);
      alert("This user could not be found!");
    });
  }

  render() {

    let getRoomDate = (room) => {
      let date;

      if (room.lastMessage) {
        date = room.lastMessage.sentAt;
      } else {
        date =  room.createdAt;
      }

      return new Date(date);
    };

    let rooms = this.props.rooms.sort((a, b) => {
      return getRoomDate(b) - getRoomDate(a);
    });

    rooms = rooms.map((room) => {
      return (
        <MenuMessage
          key={room.id}
          room={room}
        />
      );
    });

    return (
      <div className="menu">

        <div className="header">
          <h3>Messages</h3>

          <button 
            className="compose"
            onClick={this.createRoom.bind(this)}
          ></button>

        </div>

        <ul>
          {rooms}
        </ul>

      </div>
    )
  }
}

MenuContainer.defaultProps = {
  rooms: [],
};

const mapStateToProps = (state) => {
  return {
    rooms: state,
  };
};

const mapDispatchToProps = {
  setRooms,
  selectRoom,
  addRoom,
  addMessage, // Add this line!
};

MenuContainer = connect(
  mapStateToProps,
  mapDispatchToProps,
)(MenuContainer);

export default MenuContainer;
