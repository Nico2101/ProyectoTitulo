package com.app.proyectotitulo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.repository.SectorRepository;

@Service
public class SectorServiceImplementation implements SectorService {

	private SectorRepository sectorRepo;

	@Autowired
	public void setSectorRepository(SectorRepository sectorRepository) {
		sectorRepo = sectorRepository;
	}

	@Override
	public List<Sector> findAll() {
		// TODO Auto-generated method stub
		return sectorRepo.findAll();
	}
	
	@Override
	public void save(Sector s) {
		// TODO Auto-generated method stub
		sectorRepo.save(s);
	}
}
