package com.app.proyectotitulo.service;

import java.util.List;


import com.app.proyectotitulo.domain.Sector;

public interface SectorService {

	List<Sector> listarSectores(boolean sectorEliminado);
	
	Sector saveAndFlush(Sector s);
	
	Sector findByIdSector(int idSector);
	
	// Eliminar sector
		Sector eliminarSector(Sector s);
		
		// Editar Sector
		Sector editarSector(Sector s);
}
