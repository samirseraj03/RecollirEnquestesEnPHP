
    // Get the form container
    const formContainer = document.getElementById('dynamicForm');

    // Use jsonData in your JavaScript logic
    // Generate the form elements
    //jsonData.preguntes.forEach(pregunta => {
    jsonData2.enquesta.forEach(pregunta => {
        const element = createFormElement(pregunta);
        formContainer.appendChild(element);
    });

    const submit = document.createElement('button');
    submit.type =  'submit';
    submit.innerText = "Enviar";
    formContainer.appendChild(submit);

function createFormElement(pregunta) 
{
    const element = document.createElement('div');
    var label = "";
    
    if(pregunta.tipus != 'radio' && pregunta.tipus != 'checkbox')
    {
        label = document.createElement('label');
        label.textContent = pregunta.pregunta;
        label.classList.add("h4");
        label.setAttribute("for", pregunta.id);
    }
    else
    {
        label = document.createElement('h4');
        label.textContent = pregunta.pregunta;
        label.classList.add("h4");
    }
    element.appendChild(label);

    switch (pregunta.tipus) 
    {
        case 'text':
        case 'date':
        case 'email':
        case 'number':
            const input = document.createElement('input');
            input.type = pregunta.tipus;
            input.id = pregunta.id;
            input.placeholder = pregunta.placeholder;
            element.appendChild(input);
            break;

        case 'select':
            const select = document.createElement('select');
            select.id = pregunta.id;
            pregunta.opcions.forEach(opcio => {
                const option = document.createElement('option');
                option.value = opcio;
                option.textContent = opcio;
                select.appendChild(option);
            });
            element.appendChild(select);
            break;

        case 'checkbox':
            pregunta.opcions.forEach((opcio, index) => {
                const checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                checkbox.id = pregunta.id + "_" + index;
                checkbox.classList.add('exclude-styling');
                checkbox.classList.add('substituted');
                checkbox.ariaHidden = true;
                const label = document.createElement('label');
                const div = document.createElement('div');
                div.classList.add('checkbox-wrapper-1');
                label.textContent = opcio;
                label.setAttribute('for', checkbox.id);
                div.appendChild(checkbox);
                div.appendChild(label);
                element.appendChild(div);
            });
            break;

        case 'radio':
            pregunta.opcions.forEach((opcio, index)=> {
                const radio = document.createElement('input');
                radio.type = 'radio';
                radio.name = pregunta.id;
                radio.id = pregunta.id + "_" + index;
                const label = document.createElement('label');
                const div = document.createElement('div');
                label.textContent = opcio;
                label.setAttribute('for', radio.id);
                div.appendChild(radio);
                div.appendChild(label);
                element.appendChild(div);
            });
            break;

        case 'textarea':
            const textarea = document.createElement('textarea');
            textarea.id = pregunta.id;
            textarea.placeholder = pregunta.placeholder;
            element.appendChild(textarea);
            break;
    }

    return element;
}