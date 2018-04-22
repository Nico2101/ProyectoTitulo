package com.app.proyectotitulo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.repository.PredioRepository;

@Service
public class PredioServiceImplementation implements PredioService {

	private PredioRepository predioRepo;

	@Autowired
	public void setPredioRepository(PredioRepository predioRepository) {
		predioRepo = predioRepository;
	}

	@Override
	public List<Predio> findAll() {
		// TODO Auto-generated method stub
		return predioRepo.findAll();
	}

}
