module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{gleam,mjs}",
    "../server/**/*.{gleam,mjs}",
  ],
  theme: {
    extend: {
      colors: {
        // Thanks to https://gist.github.com/apaleslimghost/0d25ec801ca4fc43317bcff298af43c3 for the colours
        normal: "#A8A77A",
        fire: "#EE8130",
        water: "#6390F0",
        electric: "#F7D02C",
        grass: "#7AC74C",
        ice: "#96D9D6",
        fighting: "#C22E28",
        poison: "#A33EA1",
        ground: "#E2BF65",
        flying: "#A98FF3",
        psychic: "#F95587",
        bug: "#A6B91A",
        rock: "#B6A136",
        ghost: "#735797",
        dragon: "#6F35FC",
        dark: "#705746",
        steel: "#B7B7CE",
        fairy: "#D685AD",
      },
    },
    fontFamily: {
      "press-start-2p": ["'Press Start 2P'", "display"],
    },
  },
  plugins: [],
};
