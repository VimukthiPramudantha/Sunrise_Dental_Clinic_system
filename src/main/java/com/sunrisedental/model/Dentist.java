package com.sunrisedental.model;

import java.math.BigDecimal;

public class Dentist {
    private int id;
    private String fullName;
    private String specialization;
    private BigDecimal consultationFee;

    public Dentist() {}

    public Dentist(int id, String fullName, String specialization, BigDecimal consultationFee) {
        this.id = id;
        this.fullName = fullName;
        this.specialization = specialization;
        this.consultationFee = consultationFee;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public BigDecimal getConsultationFee() { return consultationFee; }
    public void setConsultationFee(BigDecimal consultationFee) { this.consultationFee = consultationFee; }
}