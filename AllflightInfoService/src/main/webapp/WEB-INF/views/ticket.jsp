<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Flight Ticket</title>
<script src="https://cdn.jsdelivr.net/npm/qrcodejs@1.0.0/qrcode.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
 
 
 
<script>
(function() {
    const savedTheme = localStorage.getItem('theme') || 'light';
    const themeHref = savedTheme === 'dark'
        ? '/allflightinfoservicecss/ticketcss/ticketdark.css'
        : '/allflightinfoservicecss/ticketcss/ticketlight.css';
 
    const link = document.createElement('link');
    link.rel = 'stylesheet';
    link.href = themeHref;
    link.id = 'theme-link';
    document.head.appendChild(link);
 
 
})();
</script>
</head>
<body>
	<a href="/homePage" class="back-button">← Back </a>
	<div class="ticket-container" id="ticket-container">
		<h1 class="main-heading">Flight Details</h1>
		<div class="booked">
			<% String username = (String) request.getAttribute("username"); %>
                	<% if (username != null) { %>
                	    <div class="user-info">Booked by: <strong><%= username %></strong></div>
                	<% } %>
                	</div>
                	
		<div class="qr-section">
			<div id="qrcode"></div>
		</div>
		<div class="details-grid" id="details-container"></div>
		<a href="#" class="print-button" onclick="downloadPDF();">Print
			Ticket</a>
	</div>
 
	<script>
    	
    	let flightDetailsForQr = "";
    	const id = ${flightId};
    
    	fetch('allflightinfoapi/flightById?id=' + id)
		.then(response => {
	        if (!response.ok) {
	            throw new Error('Network response was not ok');
	        }
	        return response.json();
	    })
	    .then(flight => {
	    	const ticket_container = document.getElementById('ticket-container');
	        const details_container = document.getElementById('details-container');
	        if (!flight || flight.length === 0) {
	            ticket_container.innerHTML = "<p style='text-align: center;'>No flight details available</p>";
	        } else {
            	flightDetailsForQr =  JSON.stringify(flight);
            	console.log(flightDetailsForQr);
            	const flightIdStr = String(flight.id);
            	const airlineNameStr = String(flight.name);
            	const flightTypeStr = String(flight.type);
 
            	const flightDateStr = String(flight.date);
            	const flightSourceStr = String(flight.source);
            	const flightDestinationStr = String(flight.destination);
 
            	const departureTimeStr = String(flight.departure);
            	const arrivalTimeStr = String(flight.arrival);
            	const flightDurationStr = String(flight.duration);
 
            	const flightFare = flight.fare;
            	
            	new QRCode(document.getElementById("qrcode"), {
            	    text: flightDetailsForQr,
            	    width: 150,
            	    height: 150,
            	    colorDark: "#000000",
            	    colorLight: "#ffffff",
            	    correctLevel: QRCode.CorrectLevel.M // Changed from H to M
            	});
            	
            	let logoUrl = '';
 
            	// Check the airline name and assign the correct URL
            	if (airlineNameStr === "Air India") {
            	    logoUrl = "https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/AI.png?v=20";
            	} else if (airlineNameStr === "SpiceJet") {
            	    logoUrl = "https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/SG.png?v=20";
            	} else if (airlineNameStr === "IndiGo") {
            	    logoUrl = "https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/6E.png?v=20";
            	} else if (airlineNameStr === "Akasa Air") {
            	    logoUrl = "https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/QP.png?v=20";
            	} else {
            	    // A default URL or a blank string if the airline is not found
            	    logoUrl = "https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/6E.png?v=20";
            	}
 
            	// Create a formatter for Indian Rupees
            	const inrFormatter = new Intl.NumberFormat('en-IN', {
            	  style: 'currency',
            	  currency: 'INR',
            	  minimumFractionDigits: 0,
            	});
 
            	const flightFareStr = inrFormatter.format(flightFare);
            	
            	const modifiedDepartureTimeStr = departureTimeStr.slice(0, -3);
            	const modifiedarrivalTimeStr = arrivalTimeStr.slice(0, -3);
            	
            	const parts = flightDurationStr.split(':');
          
            	const formattedDuration = `\${parts[0]} h \${parts[1]} m`;
 
				
                const cardHtml = `
                
                
 
                	<div>
	                    <p class="detail-label">Flight ID</p>
	                    <p class="detail-value detail-value-highlight">\${flightIdStr}</p>
	                </div>
	                <div>
	                    <p class="detail-label">Flight Name</p>
	                    <p class="detail-value detail-value-highlight">\${airlineNameStr}</p>
	                </div>
	
	                <div>
	                    <p class="detail-label">Source</p>
	                    <p class="detail-value">\${flightSourceStr}</p>
	                </div>
	                <div>
	                    <p class="detail-label">Destination</p>
	                    <p class="detail-value">\${flightDestinationStr}</p>
	                </div>
	                
	                <div>
	                    <p class="detail-label">Type</p>
	                    <p class="detail-value">\${flightTypeStr}</p>
	                </div>
	                <div>
	                    <p class="detail-label">Fare</p>
	                    <p class="detail-value">\${flightFareStr}</p>
	                </div>
	
	                <div>
	                    <p class="detail-label">Date</p>
	                    <p class="detail-value">\${flightDateStr}</p>
	                </div>
	                <div>
	                    <p class="detail-label">Duration</p>
	                    <p class="detail-value">\${formattedDuration}</p>
	                </div>
	
	                <div>
	                    <p class="detail-label">Departure</p>
	                    <p class="detail-value">\${modifiedDepartureTimeStr}</p>
	                </div>
	                <div>
	                    <p class="detail-label">Arrival</p>
	                    <p class="detail-value">\${modifiedarrivalTimeStr}</p>
	                </div>
 
				`;
                details_container.innerHTML += cardHtml;
	        }
	    })
	    .catch(error => {
	        console.error("Error fetching flight data:", error);
	        const ticket_container = document.getElementById('flight-card-container');
	        container.innerHTML = "<p style='text-align: center; color: black;'>Error loading data. Please check your network and try again.</p>";
	    });
        
        /* document.addEventListener('DOMContentLoaded', function() {
            new QRCode(document.getElementById("qrcode"), {
                text: flightDetailsForQr,
                width: 150,
                height: 150,
                colorDark: "#000000",
                colorLight: "#ffffff",
                correctLevel: QRCode.CorrectLevel.H
            });
        }); */
        
        function downloadPDF() {
            const ticketElement = document.getElementById('ticket-container');
            if (!ticketElement) {
                console.error("The element with ID 'ticket' was not found.");
                return;
            }
            html2canvas(ticketElement).then(canvas => {
 
                const { jsPDF } = window.jspdf;
                const pdf = new jsPDF('p', 'mm', 'a4');
 
                const canvasImageWidth = canvas.width;
                const canvasImageHeight = canvas.height;
 
                const pdfWidth = pdf.internal.pageSize.getWidth();
                const pdfHeight = pdf.internal.pageSize.getHeight();
 
                const aspectRatio = canvasImageWidth / canvasImageHeight;
 
                const imgWidth = pdfWidth * 0.8;
                const imgHeight = imgWidth / aspectRatio;
 
                const xOffset = (pdfWidth - imgWidth) / 2;
                const yOffset = (pdfHeight - imgHeight) / 2;
 
                const imageData = canvas.toDataURL('image/png');
 
                pdf.addImage(imageData, 'PNG', xOffset, yOffset, imgWidth, imgHeight);
 
                pdf.save('Flight_Ticket.pdf');
            }).catch(error => {
                console.error("PDF generation failed:", error);
            });
        }
        
        
        
        
        
        
        
        
        
    </script>
</body>
</html>
 