// Declare variables for getting the xml file for the XSL transformation (folio_xml) and to load the image in IIIF on the page in question (number).
let tei = document.getElementById("folio");
let tei_xml = tei.innerHTML;
let extension = ".xml";
let folio_xml = tei_xml.concat(extension);
let page = document.getElementById("page");
let pageN = page.innerHTML;
let number = Number(pageN);

// Loading the IIIF manifest
var mirador = Mirador.viewer({
  "id": "my-mirador",
  "manifests": {
    "https://iiif.bodleian.ox.ac.uk/iiif/manifest/53fd0f29-d482-46e1-aa9d-37829b49987d.json": {
      provider: "Bodleian Library, University of Oxford"
    }
  },
  "window": {
    allowClose: false,
    allowWindowSideBar: true,
    allowTopMenuButton: false,
    allowMaximize: false,
    hideWindowTitle: true,
    panels: {
      info: false,
      attribution: false,
      canvas: true,
      annotations: false,
      search: false,
      layers: false,
    }
  },
  "workspaceControlPanel": {
    enabled: false,
  },
  "windows": [
    {
      loadedManifest: "https://iiif.bodleian.ox.ac.uk/iiif/manifest/53fd0f29-d482-46e1-aa9d-37829b49987d.json",
      canvasIndex: number,
      thumbnailNavigationPosition: 'off'
    }
  ]
});


// function to transform the text encoded in TEI with the xsl stylesheet "Frankenstein_text.xsl", this will apply the templates and output the text in the html <div id="text">
function documentLoader() {
  Promise.all([
    fetch(folio_xml).then(response => response.text()),
    fetch("Frankenstein_text.xsl").then(response => response.text())
  ])
  .then(function ([xmlString, xslString]) {
    var parser = new DOMParser();
    var xml_doc = parser.parseFromString(xmlString, "text/xml");
    var xsl_doc = parser.parseFromString(xslString, "text/xml");

    var xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(xsl_doc);
    var resultDocument = xsltProcessor.transformToFragment(xml_doc, document);

    var criticalElement = document.getElementById("text");
    criticalElement.innerHTML = ''; // Clear existing content
    criticalElement.appendChild(resultDocument);
  })
  .catch(function (error) {
    console.error("Error loading documents:", error);
  });
}
  
// function to transform the metadata encoded in teiHeader with the xsl stylesheet "Frankenstein_meta.xsl", this will apply the templates and output the text in the html <div id="stats">
function statsLoader() {
  Promise.all([
    fetch(folio_xml).then(response => response.text()),
    fetch("Frankenstein_meta.xsl").then(response => response.text())
  ])
  .then(function ([xmlString, xslString]) {
    var parser = new DOMParser();
    var xml_doc = parser.parseFromString(xmlString, "text/xml");
    var xsl_doc = parser.parseFromString(xslString, "text/xml");

    var xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(xsl_doc);
    var resultDocument = xsltProcessor.transformToFragment(xml_doc, document);

    var criticalElement = document.getElementById("stats");
    criticalElement.innerHTML = ''; // Clear existing content
    criticalElement.appendChild(resultDocument);
  })
  .catch(function (error) {
    console.error("Error loading documents:", error);
  });
}

// Initial document load
documentLoader();
statsLoader();

// Event listener for sel1 change
function selectHand(event) {
  var text = document.getElementById('text');
  var visible_mary = document.getElementsByClassName('hand-MWS');
  var visible_percy = document.getElementsByClassName('hand-PBS');
  
  var MaryArray = Array.from(visible_mary);
  var PercyArray = Array.from(visible_percy);

  if (event.target.value == 'both') {
    text.style.color = 'black';
    text.style.opacity = '1';
    MaryArray.forEach(element => {
      element.style.color = 'black';
      element.style.opacity = '1';
    });
    PercyArray.forEach(element => {
      element.style.color = 'black';
      element.style.opacity = '1';
    });
    
  } else if (event.target.value == 'Mary') {
    text.style.color = 'green';
    text.style.opacity = '1';
    MaryArray.forEach(element => {
      element.style.color = 'green';
      element.style.opacity = '1';
    });
    PercyArray.forEach(element => {
      element.style.color = 'black';
      element.style.opacity = '0.5';
    });

  } else if (event.target.value == 'Percy') {
    text.style.color = 'black';
    text.style.opacity = '05';
    PercyArray.forEach(element => {
      element.style.color = 'blue';
      element.style.opacity = '1';
    });
    MaryArray.forEach(element => {
      element.style.color = 'black';
      element.style.opacity = '0.5';
    });
  }
}


// Function to toggle the display of deletions
function toggleDeletions() {
  var deletions = document.getElementsByTagName('del');
  for (var i = 0; i < deletions.length; i++) {
    if (deletions[i].style.display === 'none') {
      deletions[i].style.display = 'inline';
    } else {
      deletions[i].style.display = 'none';
    }
  }
}

// Function for reading text view
function showReadingText() {
  const deletions = document.querySelectorAll('del');
  const additions = document.querySelectorAll('add');
  
  // Toggle between reading view and normal view
  if (deletions[0]?.style.display !== 'none') {
    // Switch to reading view
    deletions.forEach(del => {
      del.style.display = 'none';
    });
    additions.forEach(add => {
      add.style.position = 'static';
      add.style.verticalAlign = 'baseline';
    });
  } else {
    // Switch back to normal view
    deletions.forEach(del => {
      del.style.display = 'inline';
    });
    additions.forEach(add => {
      add.style.position = '';
      add.style.verticalAlign = '';
    });
  }
}