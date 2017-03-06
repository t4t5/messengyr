// assets/js/actions.js

export function setRooms(rooms) {
  return {
    type: "SET_ROOMS",
    rooms,
  }
};

export function selectRoom(roomId) {
  return {
    type: "SELECT_ROOM",
    roomId,
  }
};

export function addRoom(room) {
  return {
    type: "ADD_ROOM",
    room,
  }
};
