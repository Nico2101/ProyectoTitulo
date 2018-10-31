//Obtener datos planes
$
		.ajax({
			type : 'POST',
			url : "resumenPlanesMasReprogramados",
			dataType : 'json',
			success : function(data) {
				console.log(data);

				// Crear grafico

				// Donut chart

				var arregloColores = Array();
				var arregloLabel = Array();
				var arregloDataSets = Array();
				for (var i = 0; i < data.length; i++) {
					// Codigo para generar los colores random
					var color = 'rgb(' + (Math.floor(Math.random() * 256))
							+ ',' + (Math.floor(Math.random() * 256)) + ','
							+ (Math.floor(Math.random() * 256)) + ')';

					var nombre = data[i].nombrePlan;

					var dataS = data[i].total;

					// Guardar en los arreglos
					arregloColores.push(color);
					arregloLabel.push(nombre);
					arregloDataSets.push(dataS);

				}

				var myDonut = new Chart(
						document.getElementById("pieChartPlanes"),
						{
							type : 'pie',
							data : {
								labels : arregloLabel,
								datasets : [ {
									label : "Total Actividad Reprogramadas",
									backgroundColor : arregloColores,
									data : arregloDataSets
								} ]
							},
							options : {
								title : {
									display : true,
									text : ''// Titulo del grafico
								},
								tooltips : {
									mode : 'index',
									intersect : false,
									callbacks : {
										label : function(tooltipItem, datos) {

											return datos.labels[tooltipItem.index]
													+ " : "
													+ datos.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]
													+ " reprogramaciones";
										}

									}
								}
							}
						});

			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener los datos");
			}
		});

// Obtener datos planes
$
		.ajax({
			type : 'POST',
			url : "getTotalActividadesReprogramadas",
			dataType : 'json',
			success : function(data) {
				console.log(data);

				// Crear grafico

				// Donut chart

				var arregloColores = Array();
				var arregloLabel = Array();
				var arregloDataSets = Array();
				for (var i = 0; i < data.length; i++) {
					// Codigo para generar los colores random
					var color = 'rgb(' + (Math.floor(Math.random() * 256))
							+ ',' + (Math.floor(Math.random() * 256)) + ','
							+ (Math.floor(Math.random() * 256)) + ')';

					var nombre = data[i].nombreActividad + " - "
							+ data[i].nombrePlan;

					var dataS = data[i].total;

					// Guardar en los arreglos
					arregloColores.push(color);
					arregloLabel.push(nombre);
					arregloDataSets.push(dataS);

				}

				var myDonut = new Chart(
						document.getElementById("pieChartActividades"),
						{
							type : 'pie',
							data : {
								labels : arregloLabel,
								datasets : [ {
									label : "Total Actividad Reprogramadas",
									backgroundColor : arregloColores,
									data : arregloDataSets
								} ]
							},
							options : {
								title : {
									display : true,
									text : ''// Titulo del grafico
								},
								tooltips : {
									mode : 'index',
									intersect : false,
									callbacks : {
										label : function(tooltipItem, datos) {

											return datos.labels[tooltipItem.index]
													+ " : Total Reprogramaciones: "
													+ datos.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
										}

									}
								}
							}
						});

			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener los datos");
			}
		});