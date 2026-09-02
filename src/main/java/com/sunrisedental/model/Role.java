package com.sunrisedental.model;

public enum Role {
    ADMIN("ADMIN"),
    RECEPTIONIST("RECEPTIONIST"),
    DENTIST("DENTIST");

    private final String roleName;

    Role(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleName() {
        return roleName;
    }

    public static Role fromString(String roleStr) {
        for (Role r : Role.values()) {
            if (r.roleName.equalsIgnoreCase(roleStr)) {
                return r;
            }
        }
        throw new IllegalArgumentException("Invalid Role: " + roleStr);
    }

    public boolean canManageAppointments() {
        return this == ADMIN || this == RECEPTIONIST;
    }

    public boolean canManageBilling() {
        return this == ADMIN || this == RECEPTIONIST;
    }

    public boolean canManageUsers() {
        return this == ADMIN;
    }
}