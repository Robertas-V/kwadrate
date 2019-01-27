import { Elm } from './src/Main.elm';

const storageKey = 'store';
const flags = localStorage.getItem(storageKey);
const node = document.querySelector('main');

Elm.Main.init({ node, flags });

// app.ports.storeCache.subscribe(val => {
//     if (val === null) {
//         localStorage.removeItem(storageKey);
//     } else {
//         localStorage.setItem(storageKey, JSON.stringify(val));
//     }

//     // Report that the new session was stored successfully.
//     setTimeout(() => {
//         app.ports.onStoreChange.send(val);
//     }, 0);
// });

// // Whenever localStorage changes in another tab, report it if necessary.
// window.addEventListener(
//     'storage',
//     event => {
//         if (event.storageArea === localStorage && event.key === storageKey) {
//             app.ports.onStoreChange.send(event.newValue);
//         }
//     },
//     false
// );
