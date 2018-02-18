
function execCopy(string) {

    let temp = document.createElement('div')

    temp.appendChild(document.createElement('pre')).textContent = string

    let s = temp.style
    s.position = 'fixed'
    s.left = '-100%'

    document.body.appendChild(temp)
    document.getSelection().selectAllChildren(temp)

    const result = document.execCommand('copy')

    document.body.removeChild(temp)
    return result
}

let classList = document.querySelectorAll('.project_source')

Object.keys(classList).map(i => {
    i.onclick = (e) => {
        const key = e.target.className === 'project_source' ? e.target.id : e.target.parentElement.id
        const name = `source_${key}`
        const string = document.getElementById(name).innerText
        execCopy(string) ? console.log('success') : console.log('fatal')
    }
})
