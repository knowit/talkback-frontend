export default async event => {
  await new Promise(() => {
    // TODO: This should react to getMessages/getUsers from graphcool
    console.log('from graphcool: ', event);
    return event.data;
  });
};