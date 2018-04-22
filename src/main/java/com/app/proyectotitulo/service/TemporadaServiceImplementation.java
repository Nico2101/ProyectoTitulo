package com.app.proyectotitulo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.repository.TemporadaRepository;

@Service
public class TemporadaServiceImplementation implements TemporadaService {

	private TemporadaRepository temporadaRepo;

	@Autowired
	public void setTemporadaRepository(TemporadaRepository temporadaRepository) {
		temporadaRepo = temporadaRepository;
	}

}
