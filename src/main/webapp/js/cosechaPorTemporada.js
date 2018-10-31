function generarReporte() {
	// Obtener temporada
	var aux = false;
	var idTemporada = $('#temporada').val();
	if (idTemporada < 0) {
		document.getElementById('temporada').style.border = "1px solid red";
		document.getElementById('errorTemporada').style.display = 'inline';
	} else {
		document.getElementById('temporada').style.border = "";
		document.getElementById('errorTemporada').style.display = 'none';

	}

	if (idTemporada > 0) {
		$
				.ajax({
					type : 'POST',
					url : "verificarDatosReporteTemporadas",
					dataType : 'json',
					data : {
						idTemporada : idTemporada
					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {
							if (data[0].cantidadCosechada == null) {
								toastr
										.error("No existen registros de cosecha para la temporada seleccionada");
							} else {
								location.href = "generarReporteTemporada?idTemporada="
										+ idTemporada;
							}

						} else {

							toastr
									.error("No hay datos en la temporada seleccionada");
						}

					},
					error : function(jqXHR, errorThrown) {
						alert("Error al verificar la temporada");
					}
				});
	}

}