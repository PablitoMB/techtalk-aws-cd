const gifs = [
    'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNmRyc2V2ZHkzZ2hxZHk2ajR5dTd0bDhtZTV1eGgydTJ0eWhnd2IyMCZlcD12MV9naWZzX3NlYXJjaCZjdD1n/393kszFi2PuCEopURN/giphy.gif',
    'https://media.giphy.com/media/1APaqOO5JHnWKLc7Bi/giphy.gif?cid=790b76116drsevdy3ghqdy6j4yu7tl8me5uxh2u2tyhgwb20&ep=v1_gifs_search&rid=giphy.gif&ct=g',
    'https://media.giphy.com/media/ZAwF2sVE5kPJn49gC2/giphy.gif?cid=ecf05e47z4lgt9hac36coojw8153l82yaf3d7twh8mf17m5e&ep=v1_gifs_search&rid=giphy.gif&ct=g',
]

export const getRandomGif = () => {
    return gifs[Math.floor(Math.random() * gifs.length)]
}
