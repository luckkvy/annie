<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Moon</title>
<link rel="stylesheet" href="styles.css">

<style>
    body {
        font-family: courier, monospace;
        background: #0f0f0f;
        color: #fafafa;
        text-align: center;
        overflow: hidden;
    }

    /* Responsive container scaled based on viewport height */
    .scene {
        position: relative;
        width: auto;
        height: 90vh;        /* Takes 90% of screen height */
        margin: 0 auto;
    }

    /* Each layer stays proportional */
    .layer {
        position: absolute;
        inset: 0;
        width: 100%;
        height: 100%;
        object-fit: contain; /* Prevents stretching/squishing */
        pointer-events: none;
    }

    #pupils {
        transition: transform 0.05s linear;
        object-fit: contain;
    }

#nextBtn {
    font-family: courier, monospace;
    font-size: 22px;
    padding: 10px 20px;
    cursor: pointer;

    position: fixed;
    bottom: 30px;  /* distance from bottom */
    left: 50%;
    transform: translateX(-50%);
}

</style>

</head>
<body>

<!-- ART LAYERS -->
<div class="scene">
    <!-- 1. Background (does NOT move) -->
    <img id="bg" class="layer" src="https://i.ibb.co/cSZh0K34/Illustration95-3.png">

    <!-- 2. Eye whites (do NOT move) -->
    <img id="whites" class="layer" src="https://i.ibb.co/jqzCWKX/Illustration95-6.png">

    <!-- 3. Pupils (move) -->
    <img id="pupils" class="layer" src="https://i.ibb.co/rRQvHT14/Illustration95.png">

    <!-- 4. Character (eyes cut out) -->
    <img id="charBase" class="layer" src="https://i.ibb.co/wFJQVRCX/Illustration95-1.png">

    <!-- 5. Character top layer -->
    <img id="charTop" class="layer" src="https://i.ibb.co/LzVmjStP/Illustration95-4.png">
</div>

<button id="nextBtn">next</button>

<script>
/* ---------------------------
   URL ORDER SYSTEM
----------------------------*/
const params = new URLSearchParams(window.location.search);
const order = params.get("order")?.split(",").map(n => parseInt(n)) || [1];
const currentPage = 1;
const currentIndex = order.indexOf(currentPage);

// Determine next page in shuffled order
let nextPage = null;
if (currentIndex >= 0 && currentIndex < order.length - 1) {
    nextPage = order[currentIndex + 1];
}

document.getElementById("nextBtn").onclick = () => {
    if (nextPage) {
        window.location.href = `page${nextPage}.html?order=${order.join(",")}`;
    }
};

/* ---------------------------
   EYE TRACKING (ONLY PUPILS)
----------------------------*/
const pupils = document.getElementById("pupils");
const scene = document.querySelector(".scene");

document.addEventListener("mousemove", (e) => {
    const rect = scene.getBoundingClientRect();

    const mouseX = e.clientX - rect.left;
    const mouseY = e.clientY - rect.top;

    const centerX = rect.width * 0.5;  /* middle of artwork */
    const centerY = rect.height * 0.5;

    const dx = mouseX - centerX;
    const dy = mouseY - centerY;

    const maxMove = rect.width * 0.005; /* scales with browser size */

    const distance = Math.sqrt(dx*dx + dy*dy);
    const ratio = distance > maxMove ? maxMove / distance : 1;

    pupils.style.transform = `translate(${dx * ratio}px, ${dy * ratio}px)`;
});
</script>

</body>
</html>

