// assets/js/reducers.js

//// We create a new function to take care
// of the state of a room's messages:
export const messages = (state = [], action) => {
  switch (action.type) {
    case "ADD_MESSAGE":
      // Add the new message to the list of messages:
      return [
        ...state,
        action.message,
      ];

    default:
      return state;
  }
};

const room = (state, action) => {
  switch (action.type) {
    case "SELECT_ROOM":
      let isActive = (state.id === action.roomId);

      return Object.assign({}, state, {
        isActive,
      });

    case "ADD_MESSAGE":
      if (state.id !== action.roomId) {
        return state;
      }

      return Object.assign({}, state, {
        messages: messages(state.messages, action)
      });

    default:
      return state;
  }
};

const rooms = (state = [], action) => {
  switch (action.type) {
    case "SET_ROOMS":
      return action.rooms;

    case "SELECT_ROOM":
      return state.map(r => {
        return room(r, action);
      });

    case "ADD_ROOM":
      return [
        action.room,
        ...state,
      ];

    case "ADD_MESSAGE":
      return state.map(r => {
        return room(r, action);
      });

    default:
      return state;
  }
};

export default rooms;
