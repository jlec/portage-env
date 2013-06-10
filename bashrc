post_src_install() {
	if $(grep -q "is valid for" ${PORTAGE_LOG_FILE}); then
		addwrite /var/log/portage/flags.log
		#echo "$(date) ${PORTAGE_LOG_FILE}" >> /var/log/portage/flags.log
		ewarn "**************************************************"
		ewarn "MIXING OF FLAGS DETECTED"
		ewarn "$(grep "is valid for" ${PORTAGE_LOG_FILE})"
		ewarn "consult ${PORTAGE_LOG_FILE}"
		ewarn "**************************************************"
	fi
	if $(grep -q "command not found" ${PORTAGE_LOG_FILE}); then
		ewarn "**************************************************"
		ewarn "Some commands may be NEEDED"
		ewarn "$(grep "command not found" ${PORTAGE_LOG_FILE})"
		ewarn "**************************************************"
	fi
#	if $(grep -q "I am stupidly using" ${PORTAGE_LOG_FILE}); then
#		ewarn "**************************************************"
#		ewarn "Some not native compiler used be NEEDED"
#		ewarn "$(grep "I am stupidly using" ${PORTAGE_LOG_FILE})"
#		ewarn "**************************************************"
#	fi

#	for a in c89 c99 cc c++ cpp gcc g++ c++ g77 gcj gcjh gfortran gccgo; do
#	i="/usr/bin/${a}"
#	addwrite ${i}
#	cat > ${i} <<- EOF
#	echo "I am stupidly using ${i}"
#	x86_64-pc-linux-gnu-$(basename ${i}) \$@
#	EOF
#	chmod 775 ${i}
#	done
}

post_pkg_postinst() {
	xz -ve9 ${PORTAGE_LOG_FILE}
	localepurge
}

post_pkg_postrm() {
	xz -ve9 ${PORTAGE_LOG_FILE}
}
