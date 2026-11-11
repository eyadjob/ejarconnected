package automation.framework.ApiAutomation.beans;

import java.util.List;

public class VehicleRequestRecord {

    public record CreateVehicleRequest(VehicleDto[] vehicleDtos) {
    }

    public record VehicleDto(
            Boolean isBulkUploaded,
            String odometer,
            int fuelId,
            String branchId,
            VehicleManufacturingInfo vehicleManufacturingInfo,
            VehicleLicenseInfo vehicleLicenseInfo,
            VehicleInsuranceInfo vehicleInsuranceInfo,
            LocationInfo locationInfo,
            PurchaseInfo purchaseInfo,
            Specs specs,
            String countryId) {

        public record VehicleManufacturingInfo(
                String modelId,
                int year,
                String chassisNo) {
        }

        public record VehicleLicenseInfo(
                String licenseTypeId,
                String usageTypeId,
                String plateNo) {
        }

        public record VehicleInsuranceInfo(
                String expiryDate,
                String number,
                String insuranceCompanyId,
                int accidentPolicyId) {
        }

        public record LocationInfo(
                String currentLocationId) {
        }

        public record PurchaseInfo(
                String vendorId,
                String date,
                String price) {
        }

        public record Specs(
                String colorId,
                String trimLevelId,
                String fuelTypeId,
                int fuelTankSize,
                int engineSize) {
        }
    }
}
