let msg = document.querySelector("#msg");
let msgp = document.querySelector("#msg-p");

const fecharMsg = () => msg.style.display = "none";
const setMsg = m => {
    msgp.innerHTML = m;
    msg.style.display = "block";
};