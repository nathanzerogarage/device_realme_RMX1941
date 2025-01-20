echo "Cloning Vendor Tree"
git clone https://github.com/nathanzerogarage/vendor_realme_RMX1941 -b eleven vendor/realme/RMX1941

echo "Cloning FMRadio Repository"
rm -rf packages/apps/FMRadio
git clone https://github.com/techyminati/android_packages_apps_FMRadio -b lineage-18.1-C2 packages/apps/FMRadio
