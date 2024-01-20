import { Socket } from 'phoenix';

let socket = new Socket('/socket', { params: { token: window.userToken } });

socket.connect();

let channel = socket.channel('comments:1', {});

channel
  .join()
  .receive('ok', (resp) => {
    console.log('Joined ', resp);
  })
  .receive('error', (resp) => {
    console.log('Unable to join ', resp);
  });

// You can now handle various events on the channel
channel.on('new_comment', (payload) => {
  console.log('New comment received: ', payload);
});

// Send messages to the server
// channel.push('new_comment', { body: 'Hello, new comment!' });
