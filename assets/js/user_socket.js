import { Socket } from 'phoenix';

let socket = new Socket('/socket', { params: { token: window.userToken } });

socket.connect();
// console.log('CSRF Token:', csrfToken);
console.log('User Token:', window.userToken);
let channel = socket.channel('comments:1', {});
console.log(channel);
channel
  .join()
  .receive('ok', (resp) => {
    console.log('Joined ', resp);
  })
  .receive('error', (resp) => {
    console.log('Unable to join ', resp);
  });
socket.onError((error) => {
  console.error('Socket connection error:', error);
});

socket.onClose((event) => {
  console.warn('Socket connection closed:', event);
});
// You can now handle various events on the channel
// channel.on('new_comment', (payload) => {
//   console.log('New comment received: ', payload);
// });

// Send messages to the server
// channel.push('new_comment', { body: 'Hello, new comment!' });
